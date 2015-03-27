'use strict';

var React = require('react/addons');

require('styles/Foo.sass');

var Foo = React.createClass({
  render: function () {
    return (
        <div>
          <p>Content for Foo</p>
        </div>
      );
  }
});

module.exports = Foo; 

