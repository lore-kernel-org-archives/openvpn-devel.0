Message-ID: <1431213418.23276.56.camel@...1866...>
From: David Woodhouse <dwmw2@...1866...>
Date: Sun, 10 May 2015 00:16:58 +0100
In-Reply-To: <CAOazyz0rFEN=M=pAfcPYFN9=HjfJtFCkB3h965u5O9nJVCAEJA@...278...>
References: <1430518805.21119.82.camel@...1866...>
	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
	<554D4B33.4060401@...1114...>
	<2a24fe1d092410bcd9082565e92c78b2.squirrel@...2027...>
	<e8658b8ccffc58c2499f792462893012.squirrel@...2027...>
	<20150509101724.GQ382@...1296...>
	<1431206194.4339.32.camel@...1866...>
	<CAOazyz3Gse_yi8cteVCOThUXvLF2F6VZoBtEB9PM=DxZw2e2ug@...278...>
	<1431209086.23276.8.camel@...1866...>
	<CAOazyz0rFEN=M=pAfcPYFN9=HjfJtFCkB3h965u5O9nJVCAEJA@...278...>
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

On Sun, 2015-05-10 at 01:09 +0300, Alon Bar-Lev wrote:
> 
> > If an application *knows* that it will never use PKCS#11 after a fork(),
> > as in this case where we *know* that we're always just going to exec
> > something else, it certainly doesn't *damage* the well-behaved providers
> > if we simply refrain from making that C_Initialize() call that we *know*
> > to be gratuitous in the child.
> 
> once again you are wrong and assuming your specific case if valid.

Can you explain where I'm wrong?

If there is a specific case in which we *know* that all we're ever going
to do after a fork() is exec something else, so *everything* is going to
be thrown away...

... and if we *know* that calling C_Initialize() in the child, which we
know is gratuitous in our case, is actually causing problems in some
fairly common PKCS#11 provider modules...

... and if we *know* that these bugs have actually been fixed before and
they keep recurring...

... and if we *know* that even if we fix the bugs again, people will
still be using the existing buggy versions for some time...

... why in $DEITY's name would we not want to — in accordance with
Postel's Law — *avoid* the gratuitous call to C_Initialize() which is
triggering the issue?

-- 
dwmw2



