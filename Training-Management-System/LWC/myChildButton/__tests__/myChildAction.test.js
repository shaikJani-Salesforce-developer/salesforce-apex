import { createElement } from '@lwc/engine-dom';
import MyChildAction from 'c/myChildAction';

describe('c-my-child-action', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('basic test', () => {
        const element = createElement('c-my-child-action', {
            is: MyChildAction
        });

        document.body.appendChild(element);

        expect(1).toBe(1);
    });
});