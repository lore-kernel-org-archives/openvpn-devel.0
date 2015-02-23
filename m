Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 23 Feb 2015 11:04:02 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150223080402.GA5068@...2009...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...>
MIME-Version: 1.0
In-Reply-To: <20150215220144.GP8134@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Feb 15, 2015 at 23:01 +0100, Gert Doering wrote:
> Hi,
> 
> On Sun, Feb 15, 2015 at 10:05:07PM +0100, Arne Schwabe wrote:
> > Am 24.01.15 um 18:04 schrieb Vasily Kulikov:
> [..]
> > > OpenVPN itself gets new 'NEED-CERTIFICATE" command which is called when
> > > --management-external-cert is used.  It is implemented as a multiline
> > > command very similar to an existing 'RSA-SIGN' command.
> > >
> > > The patch is against commit 3341a98c2852d1d0c1eafdc70a3bdb218ec29049.
> > ACK from me to the OpenVPN part. I also tested the patch in OpenVPN for
> > Android and the RSA-SIGN still works as expected. I have not reviewed
> > the OS X contrib program (other than a quick glance at the code) but I
> > think marking it as contrib it should be allowed to be still included.
> 
> I hear Arne, and James also ACKed this ("based on testing", which Arne
> did).
> 
> I'm not merging it yet, though - Vasily, please provide a v4 of the patch
> that adds:
> 
>  - documentation of --management-external-cert in doc/openvpn.8
>  - documentation of the new management command and response in 
>    doc/management-notes.txt
>  - fix the typos in the options here (please fix the other one, too):
> 
> @@ -2221,6 +2230,8 @@ options_postprocess_verify_ce (const struct options *optio
> ns, const struct conne
>  #ifdef MANAGMENT_EXTERNAL_KEY
>            if (options->management_flags & MF_EXTERNAL_KEY)
>             msg(M_USAGE, "Parameter --external-management-key cannot be used whe
> n --pkcs12 is also specified."); 
> +          if (options->management_flags & MF_EXTERNAL_CERT)
> +           msg(M_USAGE, "Parameter --external-management-cert cannot be used wh
> en --pkcs12 is also specified.");
>  #endif
>  #endif
>          }
> 
> ... it's "--management-external-*", not "--external-management-*".
> 
> With that, I'll merge right away :-)

I've implemented the changes above, but don't send the patch yet.  While
talking with Jonathan Bullard we identified that with the current design
it is very hard to implement a simple identity template passing
independently of GUI implementation.  Currently identity template is
passed to keychain-mcd leaving aside openvpn itself and thus the openvpn
configuration file doesn't contain the identity template.  Tunnelblick or
another GUI has to start keychain-mcd and pass the identity template
itself.  The way a user notifies TB/openvpn what identity template to use
is TB-dependent: it can be e.g. storing XXX-keychain-identityTemplate
preference in Info.plist file inside .tblk directory.  Other GUI might
use a different configuration method and thus store the identity template
in some other place.  It would be better to have a single
GUI-independent way of configuring keychain-mcd.

Jonathan suggested the following method.  --management-external-cert has
a single argument, the identity template.  This template is passed as-is
to management interface client as an argument to NEED-CERTIFICATE
request.  Management interface client parses this string and chooses an
identity based on the argument.  In this case the argument is an opaque
value which is simply passed to a management interface client, which
handles it as it likes (or ignores).  Also an argument can be used with
an arbitrary management interface client, not only keychain-mcd.

We can restrict a bit a format of XXX in '--management-external-cert XXX'
option argument.  It can consist of two parts, e.g.:

    --management-external-cert 'macosx-keychain:SUBJECT:c=US'

The first part is a hint how management client should handle the
argument.  In case of keychain-mcd it parses the argument, checks
whether it starts with 'macosx-keychain:', and uses the end of the
argument as an identity template.

If the change is implemented openvpn config can contain all information
needed to start openvpn connection.  A user has to start openvpn with
the config file and to start keychain-mcd.  Specifically it would contain a
line like the following:

    management-external-cert 'macosx-keychain:SUBJECT:c=US'

With the approach in patch v3 a user has to start openvpn with the
config file, start keychain-mcd, and pass identity template as an
argument to keychain-mcd.

What do you think of the change?

Thanks,

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

