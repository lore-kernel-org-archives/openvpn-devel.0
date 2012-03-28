MIME-Version: 1.0
In-Reply-To: <4F72DD9F.3030300@...1114...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
	<CAOazyz02u3u-_Bsb9yPKb2LJ5RyvnN6jwYQLRA68VHMO8DAvHQ@...278...>
	<4F72DD9F.3030300@...1114...>
Date: Wed, 28 Mar 2012 11:48:15 +0200
Message-ID: <CAOazyz02OcvCdJJ-JHBZWcxB-99nEBOXUcCHE6fkN4eGUkyCgQ@...278...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 11:45 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> The reason for that review is that I'm not convinced adding our own
> boolean type is the way to go. =C2=A0I'd much rather see us using stdbool=
.h
> and keep using the bool for pure boolean purposes. =C2=A0Where flags need=
s to
> be used, it makes much more sense to either use a uint type, or maybe
> even typedef a flag_t type.

I usually try to avoid as much as possible the stdbool in C.
It does not worth the effort, and people tend to misuse it in various
of ways, for example storing structure with bool as a member.
As bool is not properly defined, I recommend of own bool type that
will behave the same in all platforms.

Alon.

