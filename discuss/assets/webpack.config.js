const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = (env, options) => {
    const development = options.mode !== 'production';
    return {
        entry: {
            app: glob.sync('./vendor/**/*.js').concat(['./js/app.js']),
        },
        output: {
            filename: '[name].js',
            path: path.resolve(__dirname, '../priv/static/js'),
            publicPath: '/js/',
        },
        devtool: development ? 'source-map' : undefined,
        module: {
            rules: [
                {
                    test: /\.js$/,
                    exclude: /node_modules/,
                    use: {
                        loader: 'babel-loader',
                    },
                },
                {
                    test: /\.[s]?css$/,
                    use: [MiniCssExtractPlugin.loader, 'css-loader'],
                },
            ],
        },
        plugins: [new MiniCssExtractPlugin({ filename: '../css/app.css' })],
    };
};
