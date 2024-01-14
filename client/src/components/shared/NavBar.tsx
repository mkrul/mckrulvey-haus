import { useState } from "react";

const NavBar = () => {
  const [isActive, setisActive] = useState(false);

  return (
    <nav className="navbar" role="navigation" aria-label="main navigation">
      <div className="navbar-brand">
        <a
          role="button"
          className={`navbar-burger burger ${isActive ? "is-active" : ""}`}
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
          href="/"
          onClick={() => {
            setisActive(!isActive);
          }}
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div
        id="navbarBasicExample"
        className={`navbar-menu ${isActive ? "is-active" : ""}`}
      >
        <div className="navbar-start">
          <a className="navbar-item" href="/">
            Home
          </a>

          <a className="navbar-item" href="/tasks">
            Tasks
          </a>

          <div className="navbar-item has-dropdown is-hoverable">
            <a className="navbar-link" href="/">
              Guides
            </a>

            <div className="navbar-dropdown">
              <a className="navbar-item" href="/guides/reptiles">
                Reptiles
              </a>
              <a className="navbar-item" href="/guides/plants">
                Plants
              </a>
              <a className="navbar-item" href="/guides/other">
                Other
              </a>
            </div>
          </div>
        </div>
      </div>
    </nav>
  );
};

export default NavBar;
