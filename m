References: <572C454A.1060901@...515...>
	<20160506093029.GW53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <572C7B88.3060500@...515...>
Date: Fri, 6 May 2016 14:10:00 +0300
MIME-Version: 1.0
In-Reply-To: <20160506093029.GW53051@...1296...>
Subject: Re: [Openvpn-devel] Installation failure with
 openvpn-install-2.3.10-I003-i686.exe on Windows XP 32-bit?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Fri, May 06, 2016 at 10:18:34AM +0300, Samuli Sepp=E4nen wrote:
>> I received a report on IRC that "openvpn-install-2.3.10-I003-i686.exe"
>> installer fails on Windows XP 32-bit with
>>
>> "This installer only works on Windows Vista, Windows server 2008 and abo=
ve."
>>
>> Can anyone else reproduce the above problem on Windows XP?
>
> Yes.  Happens on my XP VM too.
>
> (It first refuses to run at all due to "unknown signature", but that is
> easily fixed by right-clicking and permitting execution, but then this
> error message shows up)
>
>> The openvpn-build commit that made this error possible was 65e328c:
>>
>> <https://github.com/OpenVPN/openvpn-build/commit/65e328c89182c47d1a93398=
e04ca92199bf17af3>
>>
>> However, as it states in the commit log the code path was tested before
>> merging it.
>
> Was it ever tested on Win XP?  Seems the branch "has_tap_windows:" isn't
> taken...

 From mailing list archives:

<http://thread.gmane.org/gmane.network.openvpn.devel/11187/focus=3D11188>

So "I60x on XP" _was_ tested, but "I00x on XP" was not. Staring at the=20
NSIS code tells me that "it should work", but I need to do more testing=20
and then release a fixed installer.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

