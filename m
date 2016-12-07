References: <1480707729-19578-1-git-send-email-selva.nair@...277...>
	<20161206203324.GM78624@...1296...>
	<CAKuzo_hvXg5HWrgc1Gd++iZwtTf2aekKDuc1KHufZ+HXZ66znw@...278...>
	<20161207082908.GT78624@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7bd05578-0738-6fee-fc00-baf59cb90ba4@...515...>
Date: Wed, 7 Dec 2016 13:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <20161207082908.GT78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
 address in man page
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
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 07/12/2016 10:29, Gert Doering ha scritto:
> Hi,
>
> On Tue, Dec 06, 2016 at 05:37:15PM -0500, Selva Nair wrote:
>> Yes, it does work in tun mode (easy to test just use offset 0 on command
>> line)
>
> Good :-)
>
>> I had posted a patch ( a year ago?) which sets the offset to 0. I did not
>> remove the offset variable though it makes sense to get rid of it... Any=
way
>> the patch never got any attention :)
>
> Apologies.  I've seen the patch but got distracted.
>
> We should get this fixed after 2.4 release in master (along with lots of
> other "now we go clean this up and refactor everything" :-) ).
>
> For "fixing strange parts of openvpn" patches, please feel free to remind
> me every now and then that feedback is missing.  I'm not extending this to
> "all sorts of patches" right now, though, as I can't make promises for the
> "big change patch series"...
>
> Anyway: Samuli, how's patchwork proceeding?  Speaking of "tracking patche=
s".

Patchwork has not progressed one bit. I've been busy pushing out OpenVPN=20
releases on weekly basis, plus reviewing and testing Selva's and Ilya's=20
commits to openvpn-build and openvpn-gui which those releases need :).

I will get back to patchwork once things calm down on the OpenVPN=20
release front.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

