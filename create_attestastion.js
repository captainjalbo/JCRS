const axios = require("axios");

async function createAttestation(courierAddress, schemaId, role, condition) {
    try {
        const response = await axios.post("https://api.eas.eth/attest", {
            schemaId: schemaId,
            data: {
                subject: courierAddress,
                data: {
                    role: role,
                    condition: condition,
                    timestamp: Date.now(),
                    verifier: courierAddress,
                }
            }
        });
        console.log("Attestation created:", response.data);
    } catch (error) {
        console.error("Error creating attestation:", error);
    }
}
