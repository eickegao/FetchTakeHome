# FetchTakeHome


### Summary: Include screen shots or a video of your app highlighting its features

Here is the [video](https://drive.google.com/file/d/1U0ObhzDV_1RQuyhbLOvY0KTBmNiMSkbZ/view?usp=sharing)
- load the Recipes 
- display the recipe information
- click the recipe will open the source url
- click the video player button will open youtube url

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
- ImageCache is a crucial component because it is primarily used to retrieve images. It first checks the cache to see if the image is available. If not, then checks the disk. If the image is still not available, it will start to download the image.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent around 5.5 hours on this project. I allocated my time as follows:
- 1 hour on ImageCache and ServiceManager
- 2 hours on RecipesView,RecipeCard,EmptyView
- 1 hour on debugging
- 1 hour on unit tests
- 0.5 hour on readme                                                                                                           

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I am not sure what do you mean. It is a take home project. The url is hardcoded. If it is a real project, I may need to spend more time for my approach.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think error handling is the weakest part. For example, I have tested a lot on the error handling. For example if the large and small image are both empty.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I think for this take home you should also ask me to implement the UI tests.