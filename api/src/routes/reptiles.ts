import express, { Request, Response } from "express";

// add typescript interface for reptiles
interface Reptile {
  name: string;
  species: string;
}

const router = express.Router();

// GET /reptiles
router.get("/api/reptiles", (req: Request, res: Response) => {
  // Logic to fetch data about reptiles
  const reptiles: Reptile[] = [
    { name: "Keter", species: "Eyelash Crested Gecko" },
    { name: "Clamps", species: "Veiled Chameleon" },
    { name: "Kalira", species: "Jungle Carpet Python" },
    { name: "Spock", species: "Panther Chameleon" },
    { name: "Ripley", species: "Panther Chameleon" },
    { name: "Tick", species: "Red-Eyed Crocodile Skink" },
    { name: "Tock", species: "White-Eyed Crocodile Skink" },
  ];

  res.json(reptiles);
});

export { router };
