MIME-Version: 1.0
References: <1571304533-15614-1-git-send-email-lstipakov@...277...>
 <25c5ecd5-cd2c-1867-07ef-bcc90327cc73@...2318...>
 <1093a271-04e6-5f7d-4e13-96d40551a1f9@...277...>
In-Reply-To: <1093a271-04e6-5f7d-4e13-96d40551a1f9@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 17 Oct 2019 10:25:53 -0400
Message-ID: <CAKuzo_jvko-Fbyd9ei-5LtYTE6c02pYfD0qNt81QtyMh+fudwA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] msvc: OpenSSL 1.1.0 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Oct 17, 2019 at 8:11 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> Hi Fran=C3=A7ois,
>
> Fran=C3=A7ois Kooman kirjoitti 17.10.2019 klo 13.39:
>
> > "Version 1.1.0 will be supported until 2019-09-11" [1].
> >
> > Is there a plan to update to 1.1.1 for the Windows client?
>
> Indeed, there is probably no reason to not to switch to newer version.
> We'll include 1.1.1 into the next release.

Use of 1.1.1 on both client ans server side will default to PSS padding
for RSA signature (for TLS 1.2 and 1.3) and break
--management-external-key.

So hold-off on building Windows release with 1.1.1 unless
we can get https://patchwork.openvpn.net/patch/587/ finalized by then.

Selva

