From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] OpenVPN GUI not working with ms cert store
In-Reply-To: <Pine.LNX.4.61.0411082202130.8879@...210...>
Message-ID: <Pine.LNX.4.61.0411082310460.8879@...210...>
References: <Pine.LNX.4.61.0411082202130.8879@...210...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Nov  8 14:30:30 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 8 Nov 2004, Mathias Sundman wrote:

> I got an email from an OpenVPN GUI user today saying that it didn't work 
> together with passphrase protected keys in the MS certificate store.
>
> I had no problem reproducing it. I'm using OpenVPN 2.0-beta16, and all 
> version of OpenVPN GUI from beta1 to beta22 fails.
>
> What happends is that OpenVPN "hangs" when windows is supposed to show the 
> dialog asking the user to enter his passphrase.
>
> If openvpn is run from cmd-line it works fine, and the passphrase dialog is 
> showed, and even Michael's .NET based GUI works!
>
> But not mine ;-( For some reason the dialog is just not showed, so obviously 
> openvpn can't continue.

Why do one always find the problem yourself the minute after posting to a 
list?!

The problem was in the way I called CreateProcess(). I used the 
dwFlags = STARTF_USESHOWWINDOW and wShowWindow = SW_HIDE in the 
start_info struct.

This was no-no! It seemed to suppress also windows dialogs!

If I instead used CREATE_NO_WINDOW as dwCreationFlags in the call to 
CreateProcess(), then the openvpn console window was still hidden, but 
Windows still shows the certficate store dialogs correctly.

Thanks to the list for just existing ;-)

There will soon be a new release available of OpenVPN GUI with the fix 
included...

/Mathias

