References: <1451931741-4126-1-git-send-email-samuli@...515...>
	<572092B5.8090908@...1227...> <20160427181433.GZ53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <572314AC.7040807@...515...>
Date: Fri, 29 Apr 2016 11:00:44 +0300
MIME-Version: 1.0
In-Reply-To: <20160427181433.GZ53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Update INSTALL-win32.txt for OpenVPN
 2.3.10
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
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Wed, Apr 27, 2016 at 01:21:41PM +0300, Arne Schwabe wrote:
>> Am 04.01.16 um 20:22 schrieb samuli@...515...:
>>> From: Samuli Sepp=E4nen <samuli@...515...>
>>>
>>> OpenVPN 2.3.10 includes an OpenVPN-GUI which automatically requests ele=
vation of
>>> privileges using UAC. Modified INSTALL-win32.txt to reflect this behavi=
or.
>>
>> ACK from me. This seems to be still not applied.
>
> Well, it isn't, but I answered Samuli's mail, and he agreed that we do
> not want to go there:
>
> ---------------------------------------------------
> [..]
>> I wonder if these bits should not be removed from the INSTALL-win32.txt
>> we ship in the main openvpn repo - since this is a gui thing and happens
>> totally outside the main repo...  move it to the windows build tree,
>> maybe, and show it from the installer upon installation?
>>
>> gert
>
> Hi,
>
> Looking at the the full contents of INSTALL-win32.txt your suggestion mak=
es
> sense. I'll migrate the file to openvpn-build and then send a removal pat=
ch
> for openvpn/INSTALL-win32.txt.
> ---------------------------------------------------
>
> ... and this patch never came... :-)

Uh, I'm embarrassed :). That said, I have the task in our JIRA ("Migrate=20
INSTALL-win32.txt to openvpn-build"), so I had not forgotten about it.

Now that tap-windows6 dual-signatures seem to work, I think I'll focus=20
on cleaning up the JIRA backlog by tackling the small and easy tasks=20
such as this one in one go.

>
> So, what next?  Samuli?  Apply, based on Arne's ACK, or remove?
>
> gert

Let's continue with the original plan.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

