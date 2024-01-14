import { useState, useEffect } from "react";
import { Link } from "react-router-dom";

const ReptilesPage = () => {
  const [reptileData, setReptileData] = useState([]);

  useEffect(() => {
    const getReptiles = async () => {
      const res = await fetch("http://localhost:5000/api/reptiles");
      const data = await res.json();
      console.log(data);
      setReptileData(data);
    };

    getReptiles();
  }, []);

  return (
    <div>
      <h1 className="is-size-4 mb-4">Reptile Guides</h1>
      <ul>
        {reptileData.map((reptile: { name: string; species: string }) => (
          <li key={reptile.name} className="mb-2">
            {/* link to page for the reptile */}
            <Link to={`/guides/reptiles/${reptile.name}`}>
              {reptile.name} ({reptile.species})
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default ReptilesPage;
