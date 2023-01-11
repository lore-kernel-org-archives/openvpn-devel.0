Date: Wed, 11 Jan 2023 13:18:46 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y76pJpuYHrTikBC7@...2685...>
References: <20230110170257.113527-1-frank@...2641...>
 <Y75nx/NPVwZZePEr@...1296...>
MIME-Version: 1.0
In-Reply-To: <Y75nx/NPVwZZePEr@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] check_engine_keys: make pass with
 OpenSSL 3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

On Wed, Jan 11, 2023 at 08:39:51AM +0100, Gert Doering wrote:
> Hi,
> 
> On Tue, Jan 10, 2023 at 06:02:57PM +0100, Frank Lichtenheld wrote:
> > @@ -27,7 +27,7 @@ ${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-co
> >  # first off check we died because of a key mismatch.  If this doesn't
> >  # pass, suspect openssl of returning different messages and update the
> >  # test accordingly
> > -loggrep '(X509_check_private_key:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
> > +loggrep '(x509 certificate routines:(X509_check_private_key)?:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
> 
> This change does not convince me - assuming normal regex here, the
> original grep would have found any lines with
> 
>   X509_check_private_key:key values mismatch
> 
> in them, while the new one would find
> 
>   X509_check_private_key::key values mismatch
>   X509_check_private_key:X509_check_private_key:key values mismatch
> 
> but not "the old one with just one :"
> 
> Should this be
> 
>   (x509 certificate routines:(X509_check_private_key:)?key va...
> 
> with the second ":" part of the (...:)? zero-or-once match?

So, OpenSSL 3 prints:

x509 certificate routines::key values mismatch

yes, two colons!

OpenSSL 1.1 prints:

x509 certificate routines:X509_check_private_key:key values mismatch

My patch matches for both. But you are right that I made it slightly stricter,
since it previously we only matched on

X509_check_private_key:key values mismatch

for OpenSSL 1.1. If you would prefer that we could go for

(x509 certificate routines:|X509_check_private_key):key values mismatch

But I like my version better.  If that passes buildbot, I think it
should be "good enough".

> (... as a side note, I hate this test... it's easily the test with the
> most commits to make it behave across platforms and SSL library versions)

yeah, definitely.

Regards,
-- 
  Frank Lichtenheld

