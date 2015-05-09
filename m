Message-ID: <1431209086.23276.8.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Sat, 09 May 2015 23:04:46 +0100
In-Reply-To: <CAOazyz3Gse_yi8cteVCOThUXvLF2F6VZoBtEB9PM=DxZw2e2ug@...278...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
	<e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
	<20150509101724.GQ382@...1296...>
	<1431206194.4339.32.camel@...1866...>
	<CAOazyz3Gse_yi8cteVCOThUXvLF2F6VZoBtEB9PM=DxZw2e2ug@...278...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead
 of fork()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, 2015-05-10 at 00:57 +0300, Alon Bar-Lev wrote:
> Are you sure you want to introduce security issues resulting of
> resource leak into the child process? Example: pcsc-lite socket that
> is leaking or USB connection? In a way for the child process thus it
> being able to access the card?

Those should be opened with O_CLOEXEC anyway.

> I already fixed the OpenSC implementation at least twice in the past
> for this specific issue, and twice helped to fix the pcsc-lite issues,
> worked with p11-glue at least here[1], worked with aladdin to fix
> their product, also Siemens, Athena and others,  I guess another cycle
> is required.

Indeed :)

I posted a proof-of-concept patch for OpenSC¹ but it was more of a
demonstration of where the problem lies than a real fix. Partly because
it *does* still leak file descriptors, AFAICT.

> This fix should be in malformed providers, otherwise except of the
> above, you also damage the well behaved providers.

If an application *knows* that it will never use PKCS#11 after a fork(),
as in this case where we *know* that we're always just going to exec
something else, it certainly doesn't *damage* the well-behaved providers
if we simply refrain from making that C_Initialize() call that we *know*
to be gratuitous in the child.

-- 
dwmw2

¹ http://sourceforge.net/p/opensc/mailman/message/34086897/



