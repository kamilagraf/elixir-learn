import { Socket } from 'phoenix';
let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

const createSocket = (topicId) => {
    let channel = socket.channel(`comments:${topicId}`, {});
    channel
        .join()
        .receive('ok', (resp) => {
            console.log(resp);
            renderComments(resp.comments);
        })
        .receive('error', (resp) => {
            console.log('Unable to join', resp);
        });

    channel.on(`comments:${topicId}:new`, renderComment);

    document.querySelector('button').addEventListener('click', () => {
        const content = document.querySelector('textarea').value;
        channel.push('comment:add', { content });
    });
};

const renderComments = (comments) => {
    const renderedComments = comments.map((comment) => commentTemplate(comment));
    document.querySelector('.collection').innerHTML = renderedComments.join(' ');
};

const renderComment = (e) => {
    const renderedComment = commentTemplate(e.comment);
    document.querySelector('.collection').innerHTML += renderedComment;
};

const commentTemplate = (comment) => {
    email = comment.user ? comment.user.email : 'Anonymous';

    return `
        <li class="collection-item">
            <span>
                ${comment.content}
            </span>
            <div class="secondary-content">
                ${email}
            </div>
        </li>
    `;
};

// export default socket;
window.createSocket = createSocket;
