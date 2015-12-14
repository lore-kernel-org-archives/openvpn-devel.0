References: <CAKuzo_ikg1My8wt2nbycosHvOwKhrRQPO18hjdgqDreCMDbeoQ@...278...>
	<1450055187-17397-1-git-send-email-fish.thss@...277...>
	<20151214082619.GB24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <566ED6C6.8040001@...515...>
Date: Mon, 14 Dec 2015 16:48:38 +0200
MIME-Version: 1.0
In-Reply-To: <20151214082619.GB24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make "block-outside-dns" option
 platform agnostic
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
To: Gert Doering <gert@...1296...>, Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net


> Hi,
>
> On Sun, Dec 13, 2015 at 05:06:27PM -0800, Fish wrote:
>> Make the "block-outside-dns" option agnostic of Windows versions by dyna=
mically
>> loading WFP-related functions. Cross-compiled on Linux and tested on Win=
dows
>> XP/10.
>> ---
>>   src/openvpn/Makefile.am |   2 +-
>>   src/openvpn/init.c      |   4 -
>>   src/openvpn/options.c   |  17 ++-
>>   src/openvpn/win32.c     | 114 ++++++++-------
>>   src/openvpn/win32.h     |   1 +
>>   src/openvpn/win32_wfp.h | 361 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>
> This layout of "all the copied API bits go to win32_wfp.h" is good enough
> for me (so, mails crossed here).  Thanks.
>
> I leave the final decision on "how do we want 2.3 binaries to look like"
> (single openvpn binary with copied-API bits or xp-binary and vista+ binar=
y)
> to the windows team.  Both would work for me.

The build team (=3Dme) would definitely prefer a single binary. Building=20
separate binaries would be lots of hassle. I can give this patch a=20
feature-ACK - can't comment on the code quality due to lack of C-fu. I=20
also don't have a Windows XP to test this on.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

