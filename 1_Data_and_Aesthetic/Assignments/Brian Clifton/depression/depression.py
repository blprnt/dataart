import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm

pd.options.display.mpl_style = 'default'
FONT_LOCATION = 'assets/AkzidenzGroteskBE-Regular.otf'
font = fm.FontProperties(fname=FONT_LOCATION)

newData = []
with open('depressionMonthsData1.csv', 'rb') as f:
    reader = csv.reader(f)
    temp = []
    for i, row in enumerate(reader):
        if (i+1) % 12 == 0:
            temp.append(row[0])
            newData.append(temp)
            temp =[]
        else:
            temp.append(row[0])   
# print newData

df = pd.DataFrame(newData, columns=pd.date_range('1/1/2000',periods=12, freq='1m'))
df = df.replace(' ','',regex=True).astype('float')
dft = df.T

plt.rcParams['ytick.major.pad'] = '4'
fig, axes = plt.subplots(nrows=4, ncols=3)

fig.set_figheight(6)
fig.set_figwidth(18)

dft.ix[0].plot(ax=axes[0,0]); axes[0,0].set_title('January', fontproperties=font, fontsize=14)
dft.ix[1].plot(ax=axes[0,1]); axes[0,1].set_title('February', fontproperties=font, fontsize=14)
dft.ix[2].plot(ax=axes[0,2]); axes[0,2].set_title('March', fontproperties=font, fontsize=14)

dft.ix[3].plot(ax=axes[1,0]); axes[1,0].set_title('April', fontproperties=font, fontsize=14)
dft.ix[4].plot(ax=axes[1,1]); axes[1,1].set_title('May', fontproperties=font, fontsize=14)
dft.ix[5].plot(ax=axes[1,2]); axes[1,2].set_title('June', fontproperties=font, fontsize=14)

dft.ix[6].plot(ax=axes[2,0]); axes[2,0].set_title('July', fontproperties=font, fontsize=14)
dft.ix[7].plot(ax=axes[2,1]); axes[2,1].set_title('August', fontproperties=font, fontsize=14)
dft.ix[8].plot(ax=axes[2,2]); axes[2,2].set_title('September', fontproperties=font, fontsize=14)

dft.ix[9].plot(ax=axes[3,0]); axes[3,0].set_title('October', fontproperties=font, fontsize=14)
dft.ix[10].plot(ax=axes[3,1]); axes[3,1].set_title('November', fontproperties=font, fontsize=14)
dft.ix[11].plot(ax=axes[3,2]); axes[3,2].set_title('December', fontproperties=font, fontsize=14)

fig.tight_layout()

fig.savefig('plot.png', bbox_inches='tight', dpi=300)