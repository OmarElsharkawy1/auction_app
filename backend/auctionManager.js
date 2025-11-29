const auctionState = {
    item: {
        id: 1,
        title: "Vintage Camera",
        description: "A rare 1950s film camera in excellent condition.",
        imageUrl: "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80",
        currentPrice: 100.00,
        highestBidder: null, // { username: "..." }
        bids: [] // History of bids
    }
};

function getAuctionState() {
    return auctionState.item;
}

function placeBid(amount, user) {
    const currentPrice = auctionState.item.currentPrice;
    
    if (amount <= currentPrice) {
        return { success: false, message: "Bid must be higher than current price." };
    }

    auctionState.item.currentPrice = amount;
    auctionState.item.highestBidder = user;
    auctionState.item.bids.unshift({
        amount: amount,
        user: user,
        timestamp: new Date()
    });

    return { success: true, item: auctionState.item };
}

module.exports = { getAuctionState, placeBid };
