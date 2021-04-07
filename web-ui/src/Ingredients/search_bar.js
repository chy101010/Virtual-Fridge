// Cite: https://react-select.com/advanced#experimental
/** @jsx jsx */
import { useState } from 'react'
import { jsx } from '@emotion/react';
import { Button } from 'react-bootstrap';

import Select from 'react-select';
import { defaultTheme } from 'react-select';
import { confirmAlert } from 'react-confirm-alert';
import 'react-confirm-alert/src/react-confirm-alert.css';

import { create_owned_ingredient } from '../api';

const { colors } = defaultTheme;

const selectStyles = {
    control: provided => ({ ...provided, minWidth: 240, margin: 8 }),
    menu: () => ({ boxShadow: 'inset 0 1px 0 rgba(0, 0, 0, 0.1)' }),
};

const DropdownIndicator = () => (
    <div css={{ color: colors.neutral20, height: 24, width: 32 }}>
        <Svg>
            <path
                d="M16.436 15.085l3.94 4.01a1 1 0 0 1-1.425 1.402l-3.938-4.006a7.5 7.5 0 1 1 1.423-1.406zM10.5 16a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11z"
                fill="currentColor"
                fillRule="evenodd"
            />
        </Svg>
    </div>
);

export default function SearchBar({ ingredients }) {
    const [state, setState] = useState({
        isOpen: false,
        value: undefined,
    });

    const toggleOpen = () => {
        setState(state => ({ isOpen: !state.isOpen }));
    };

    const onSelectChange = value => {
        toggleOpen();
        confirmAlert({
            title: 'Add ' + value.label + ' to your virtual fridge?',
            message: 'Please confirm that you are adding this item.',
            buttons: [
                {
                    label: 'Yes',
                    onClick: () => {
                        create_owned_ingredient({ ingredient_name: value.label })
                        setState({ value: undefined })
                    }
                },
                {
                    label: 'No',
                    onClick: () => setState({ value: undefined })
                }
            ]
        });
    };

    const { isOpen, value } = state;
    return (
        <Dropdown
            isOpen={isOpen}
            onClose={toggleOpen}
            target={
                <Button
                    iconAfter={<ChevronDown />}
                    onClick={toggleOpen}
                    isSelected={isOpen}
                >
                    {value ? `Ingredient: ${value.label}` : 'Add Ingredient To Your Virtual Fridge'}
                </Button>
            }
        >
            <Select
                autoFocus
                backspaceRemovesValue={false}
                components={{ DropdownIndicator, IndicatorSeparator: null }}
                controlShouldRenderValue={false}
                hideSelectedOptions={false}
                isClearable={false}
                menuIsOpen
                onChange={onSelectChange}
                options={ingredients}
                placeholder="Search..."
                styles={selectStyles}
                tabSelectsValue={false}
                value={value}
            />
        </Dropdown>
    );
}

const Menu = props => {
    const shadow = 'hsla(218, 50%, 10%, 0.1)';
    return (
        <div
            css={{
                backgroundColor: 'white',
                borderRadius: 4,
                boxShadow: `0 0 0 1px ${shadow}, 0 4px 11px ${shadow}`,
                marginTop: 8,
                position: 'absolute',
                zIndex: 2,
            }}
            {...props}
        />
    );
};

const Blanket = props => (
    <div
        css={{
            bottom: 0,
            left: 0,
            top: 0,
            right: 0,
            position: 'fixed',
            zIndex: 1,
        }}
        {...props}
    />
);

const Dropdown = ({ children, isOpen, target, onClose }) => (
    <div css={{ position: 'relative' }}>
        {target}
        {isOpen ? <Menu>{children}</Menu> : null}
        {isOpen ? <Blanket onClick={onClose} /> : null}
    </div>
);

const Svg = p => (
    <svg
        width="24"
        height="24"
        viewBox="0 0 24 24"
        focusable="false"
        role="presentation"
        {...p}
    />
);


const ChevronDown = () => (
    <Svg style={{ marginRight: -6 }}>
        <path
            d="M8.292 10.293a1.009 1.009 0 0 0 0 1.419l2.939 2.965c.218.215.5.322.779.322s.556-.107.769-.322l2.93-2.955a1.01 1.01 0 0 0 0-1.419.987.987 0 0 0-1.406 0l-2.298 2.317-2.307-2.327a.99.99 0 0 0-1.406 0z"
            fill="currentColor"
            fillRule="evenodd"
        />
    </Svg>
);
