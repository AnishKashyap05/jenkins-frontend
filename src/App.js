import React, { useState } from "react";

function App() {
  const [message, setMessage] = useState("");

  const fetchMessage = async () => {
    try {
      const response = await fetch("http://localhost:8081/sayHello");
      const data = await response.text();
      setMessage(data);
    } catch (error) {
      console.error("Error fetching message:", error);
      setMessage("Failed to fetch message");
    }
  };

  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <button onClick={fetchMessage}>Say Hello</button>
      <p>{message}</p>
    </div>
  );
}

export default App;
