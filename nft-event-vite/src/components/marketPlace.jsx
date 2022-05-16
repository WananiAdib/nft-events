import {CardMedia, Typography, CardContent, Button, CardActions, Card,Grid,} from '@mui/material/';
const MarketPlace = ({ events }) => {
    return (
        <Grid
            container 
            spacing={2}
            align="center"
            justify="center"
            >
            {events.map(event => (
                <Grid 
                    item xs={12}
                    key={event.data.eventName}
                >
                    <Card sx={{ width: 2/5 }}>
                        <CardMedia
                        component="img"
                        height="140"
                        image={event.data.imageURL}
                        alt={`${event.data.eventName} description image`}
                        />
                        <CardContent>
                            <Typography gutterBottom variant="h5" component="div">
                                {event.data.eventName}
                            </Typography>
                            <Typography variant="body2" color="text.secondary">
                                {event.data.Description}
                            </Typography>
                        </CardContent>
                        <CardActions>
                            <Button size="large"  fullWidth variant="contained" sx={{ mt: 3, mb: 2 }}>BUY TICKET</Button>
                        </CardActions>
                    </Card>
                </Grid>
            ))}
        </Grid>
     );
}

export default MarketPlace;