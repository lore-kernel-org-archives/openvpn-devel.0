From: Jon Kunkee <jkunkee@...2393...>
Date: Wed, 14 Nov 2018 00:49:07 +0000
Message-ID: <DM5PR2101MB10475EA86594AD9D62AE7555B0C30@...2427...>
References: <20181010192337.6984-1-simon@...2293...>
 <20181016102627.18676-1-simon@...2293...>
 <20181016102627.18676-4-simon@...2293...>
 <DM5PR2101MB1112DB68D163884AD7ACDA80B0C50@...2412...>
 <99D61A626FDA8A4B90A270669121BE109936403D@...2294...>
 <99D61A626FDA8A4B90A270669121BE109936F62F@...2294...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE109936F62F@...2294...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add MSI custom action for reliable
 Windows 10 detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> I gave the MsiBreak method a quick try, but I couldn't make it work. I ha=
ve
> set MsiBreak as a system environment variable, restarted Windows Installer
> service, restarted the shell window from where I invoke msiexec calls to
> make sure the environment is updated. But it doesn't pop-up any prompt to
> attach debugger as advertised.

That's sad to hear. I'd toss out ideas to try, but...

> I haven't installed the Debugging Tools for Windows, as I run Visual Stud=
io
> elevated to debug processes. I haven't restarted my computer: restart of a
> working machine with stage set to debug something is a royal PITA: the
> libopenvpnmsica.dll has more than one custom property to debug, restarting
> each time to switch MsiBreak to a different custom action is not viable.

I've debugged using MsiBreak set in the admin CMD prompt I used to launch t=
he=20
MSI, so restarts aren't required. The article goes into some very nearly us=
eful=20
details about when this is, but...

> Therefore, I'd prefer to keep own MessageBox() call in the beginning of e=
ach
> custom action. It works 100%.

...not only that, but the article even suggests this:

"To start debugging without MsiBreak, put a temporary message box at the=20
beginning of the action's code. When the message box appears during the=20
installation, attach the debugger to the process owning the message box."

If you ever need to debug say, the DLL loading, then MsiBreak is the way to=
 go.=20
As it stands, it's *REALLY* hard to beat 100%. :)

> Adding PID to the message is an option. I personally never needed it. When
> running Visual Studio elevated, you press Ctrl+Alt+P, followed by "msi"
> keystrokes to focus on "msiexec.exe" processes, then observe the
> MessageBox()'s title (which is deliberately set to function name) in the
> "Title" column of the available process list. Way faster than searching
> process by PID.

I've been wrong before about how easy different options are. :)

> Anyway, I have extended the debug pop-up dialogs to be more informative a=
nd
> include PID. Patch follows...

I took a look and it looks good to me, though I agree it's not strictly nec=
essary.=20

Thanks,
Jon


