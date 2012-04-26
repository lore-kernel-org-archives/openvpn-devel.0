MIME-Version: 1.0
In-Reply-To: <20120426181708.GX1359@...1296...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
	<CAOazyz3-f2YkXE_vV2Oum+p4exQTUis=Q9RTOrvZ7WC0WEZymg@...278...>
	<20120426172410.GT1359@...1296...>
	<4F9986A2.10900@...1114...>
	<CAOazyz0Tv0_9Fqr_b8smQ0z00qk5fQ2AUaHz_75K-gQoEANDOg@...278...>
	<20120426180156.GU1359@...1296...>
	<CAOazyz3NsxGOaG97DXaksx6zfAXGBSvM-1YCbB=wkFKY5fmm-w@...278...>
	<20120426181708.GX1359@...1296...>
Date: Thu, 26 Apr 2012 21:20:14 +0300
Message-ID: <CAOazyz1RxYe4Q08YBoCyM8wAv82c92WNK+t4=DZk3S6u8ytZ3g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 26, 2012 at 9:17 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Apr 26, 2012 at 09:06:19PM +0300, Alon Bar-Lev wrote:
>> Right, the ipv6 was added indeed differently, without this conditionals.
>
> You missed the part that JJO's IPv6 code *was* added with conditionals,
> and that caused problems. =C2=A0We *removed* the conditionals, and the re=
sulting
> code is easier to maintain now.
>
>> Because of this I did not perform this task as part of the major build
>> cleanup, and left this for the next phase.
>> Most of the lowlevel network code already has #ifdefs, I will try my
>> best to find a way to do the conditional without much changes.
>
> I don't think that this is a useful way to spend your time.
>
> Nobody has ever asked for it, and I don't see anybody volunteering to
> maintain the resulting extra complications.
>
> We want to *reduce* the number of #ifdef in the code.

Not necessary, I would like to make it compatible with other well
behaved projects out there.

Alon.

