From: Gerhard Wiesinger <lists@...390...>
Subject: Re: [Openvpn-devel] Patch for Password authentication
In-Reply-To: <Pine.LNX.4.58.0505050307290.1970@...41...>
Message-ID: <Pine.LNX.4.61.0505051133570.20622@...391...>
References: <Pine.LNX.4.61.0505040740001.10953@...391...>
 <Pine.LNX.4.58.0505050307290.1970@...41...>
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
Date: Thu May  5 04:23:28 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net


On Thu, 5 May 2005, James Yonan wrote:

> On Wed, 4 May 2005, Gerhard Wiesinger wrote:
>
>> Hello!
>>
>> Attached are 2 usability patches for password authentication on Windows,
>> one for OpenVPN 2.0.0 and OpenVPN-GUI 1.0.
>>
>> The patches provide the following functionality:
>> You can provide predefined usernames for password authentication,
>> backward compatibility is guaranteed.
>>
>> It looks like the following:
>>
>> Client Config looks like:
>> =========================
>> # Ask for username and password
>> auth-user-pass user.up
>>
>> # Optionally the win32-gui switch can be set (see for combinations below)
>> win32-gui
>>
>> user.up contains:
>> =================
>> username
>> password or stdin or gui (stdin and gui are reserverd keywords)
>>
>> When password is set, the password is taken.
>> When stdin or gui is set as the password the user is asked to provide the
>> password only (The username is not queried or is already predefined in the
>> GUI dialog and the focus is set to the password text field).
>>
>> # Usefull combinations are:
>> # disabled win32-gui with auth-user-pass username/gui (Best)
>> ============================================================
>> OpenVPN Userauthentication Dialog (only one dialog appears) with the
>> following information:
>>
>> Username: gerhard (predefined as from user.up!!!)
>> Password: Enter the password here
>>
>> When a private key password is set, it is also queried.
>>
>> Username is taken from user.up
>>
>> # win32-gui with auth-user-pass username/stdin  (Best)
>> ======================================================
>> The following dialog pops up:
>> Enter Auth Password for user gerhard: Enter the username here
>>
>> When a private key password is set, it is also queried.
>>
>> Username is taken from user.up
>>
>> # win32-gui with auth-user-pass username/gui
>> ============================================
>> Enter Auth Username [gerhard]: Enter the username here
>> Enter Auth Password: Enter the password here
>>
>> When a private key password is set, it is also queried.
>>
>> # Useless combinations are:
>> # disabled win32-gui with auth-user-pass username/stdin
>> =======================================================
>> OpenVPN is blocked, since the GUI waits for input from stdin, but nothing
>> usefull is sent.
>>
>> Server side looks like:
>> =======================
>> plugin /usr/share/openvpn/plugin/lib/openvpn-auth-pam.so login
>>
>> It has been tested with MinGW compiler, Windows 2000 and Linux as a
>> server unpatched (2.0.0).
>>
>> Please let me know whether you integrate the patches in the upcoming
>> OpenVPN 2.0.1 release.
>
> Why would you want to add platform-specific GUI code to the OpenVPN core
> (as the non-GUI patch does), rather than coding the GUI functionality as
> a separate applet and communicating with the OpenVPN core via the
> management interface?  It's a bit more work this way, but it has the
> advantage of decoupling the OpenVPN core from the platform-specific GUI
> elements.
>

I only "enhanced" the already existing patch for openvpn.

See
http://openvpn.se/development.html
http://openvpn.se/files/patches/openvpn-2.0_rc16-gui.patch
for details.

Of course a management interface is a better design, but my patch (not the 
original one) also works with stdin redirection without the win32-gui 
option, so there is no platform specific code in there any more and could 
be removed. A GUI interface with platform specific DLLs, shared objects or 
something might be a better solution (e.g. plugin concept).

But from a practical point of view I don't see any problems with GUI code 
in it, do you?

Ciao,
Gerhard

