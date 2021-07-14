import { BrowserRouter as Router, Route, Redirect, Switch } from "react-router-dom";
import Home from "./Screens/Home";

function Routes() {
  return (
    <Router>
      <Switch>
        <Route exact path="/" component={Home} />
      </Switch>
    </Router>
  );
}

const PrivateRoute = ({ component: Component, ...rest}) => (
  <Route
    {...rest}
    render={props =>
      localStorage.getItem("token") ? (
        <Component {...props} />
      ) : (
        <Redirect to={{pathname: "/login", state: { from: props.location }}} />
      )
    }
  />
)

export default Routes;