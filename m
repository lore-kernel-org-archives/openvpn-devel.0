Message-ID: <4E576922.8010209@...515...>
Date: Fri, 26 Aug 2011 12:36:34 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
	<4E575276.80206@...1114...>
In-Reply-To: <4E575276.80206@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
 $KEY_CONFIG variable in easy-rsa/2.0/vars
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 18/08/11 09:25, samuli@...515... wrote:
> > From: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> > Original $KEY_CONFIG variable generation in broke if $EASY_RSA had
> whitespace in
> > it. This patch fixes the issue in a POSIX-compliant way.
>
> > Signed-off-by: Tanel Rebane <tanel@...1495...>
> > Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> > Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> > ---
> >  easy-rsa/2.0/vars |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
>
> > diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
> > index 2ea1ced..780ecf6 100755
> > --- a/easy-rsa/2.0/vars
> > +++ b/easy-rsa/2.0/vars
> > @@ -26,7 +26,7 @@ export GREP=3D"grep"
> >  # This variable should point to
> >  # the openssl.cnf file included
> >  # with easy-rsa.
> > -export KEY_CONFIG=3D`$EASY_RSA/whichopensslcnf $EASY_RSA`
> > +export KEY_CONFIG=3D$("$EASY_RSA"/whichopensslcnf "$EASY_RSA")
>
> Even though I personally like this syntax better, isn't it better to use
> the `` syntax instead of $() due to portability?  Or are we sure that $()
> functional everywhere nowadays?
>
>
> kind regards,
>
> David Sommerseth

There shouldn't be a difference, I did quite a bit of Googling just to
be sure. For example, the Dash shell seems to be used often as
POSIX-compliance reference implementation. From
<http://linux.die.net/man/1/dash>:

"Only features designated by POSIX, plus a few Berkeley extensions, are
being incorporated into this shell. We expect POSIX conformance by the
time 4.4 BSD is released."

Dash supports both $() and `` command substitution syntaces. Of course,
there might be some other shells which don't support the $() syntax. If
somebody knows any, please raise your voice :).

Samuli

