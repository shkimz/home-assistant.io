'use strict';

[...document.getElementsByClassName('terminology')].forEach(terminology => {
    const horizontalMargin = 20;

    const topMargin = document
        .getElementsByClassName('site-header')[0]
        .clientHeight;

    const tooltip = terminology.querySelector('.terminology-tooltip');
