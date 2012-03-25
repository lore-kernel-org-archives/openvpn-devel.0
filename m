MIME-Version: 1.0
In-Reply-To: <20120325111220.GH1359@...1296...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
	<20120325111220.GH1359@...1296...>
Date: Sun, 25 Mar 2012 13:16:13 +0200
Message-ID: <CAOazyz23svK7qDCuxm9sCT3+R+oDoLvU1PHyyrotPTLKXufTDA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
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
Cc: Openvpn-devel@lists.sourceforge.net

On Sun, Mar 25, 2012 at 1:12 PM, Gert Doering <gert@...1296...> wrote:
> Personally I think that this is a regression in GCC, and we should NOT
> do anything about it. =C2=A0If the compiler is documented to have a new
> data type "bool__", it should not mess with "bool", which is a different
> name by all means - bad enough that we have to jump through hoops to
> care for MSVC, but that's at least a mainstream platform, as opposed
> to "PPC with a specific compiler option (-maltivec)".

Right.
But I don't think we should be in fight with gcc... These guys are
doing a great work, without them no open source could have been
manifested.
If they chose to implement this, and this entered the standard, we
should either comply or use alternate method.

And it is not difficult to use alternate method, just long patch :)

Alon.

