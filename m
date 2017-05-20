MIME-Version: 1.0
In-Reply-To: <717aba44-6a5b-5bfc-793d-89a015636367@...2080...>
References: <CAEsd45RwFwUp84WJ9OXdtVy_cSvEw3vRMzgo9DWfyr43Ny+-dw@...278...>
	<51ef426c-c8ee-6019-c4c0-124558888fbc@...2080...>
	<86da1d4c-d798-da76-9079-6037f0c1cd9a@...515...>
	<CAEsd45Q1goosYtGHD4iZUU3ZfT+Vng8sp6F6Oo2ZuNKMVtMgpw@...278...>
	<717aba44-6a5b-5bfc-793d-89a015636367@...2080...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 20 May 2017 09:25:47 -0400
Message-ID: <CAEsd45TuPaA4gOftbkhCoESYZB+9X5TXyuZYW4pqB84aBEq_0w@...278...>
Subject: Re: [Openvpn-devel] Problem with sig for 2.3.16?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: David Sommerseth <davids@...515...>

On Fri, May 19, 2017 at 6:41 PM, David Sommerseth
<openvpn@...2080...> wrote:
> On 19/05/17 21:23, Jonathan K. Bullard wrote:
[snip]
> > OK, I get that, but the key file from the link David provided (and
> > which was also in his reply to the email announcing 2.3.16):
> >
> >  <http://pgp.mit.edu/pks/lookup?op=get&search=0x12F5F7B42F2B01E7>
> >
> > is not identical to the "Security mailing list GPG key" I just
> > downloaded from the "sig" page.
> >
> > Is that a problem?
>
> What is the difference you see?  To mem both looks identical when
> importing them into GPG.  But I haven't dug too deep into the details.

The contents of the files were different, which bothered me. I now
understand that that is OK -- I apologize for being too paranoid :)

They import identically for me, so all is well.


> One detail though, the "real" key ID is always the finger print.  Then
> there is two types of key IDs, one short and one long.  But those are
> just from the last bytes from the fingerprint.
>
> Key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01E7
> Key ID - long:                                  12F5 F7B4 2F2B 01E7
> Key ID - short:                                           2F2B 01E7

Ah. Thanks for the explanation. That makes sense! :)


> When I import both keys into the different brand new GPG key rings, I do
> get the same result when listing these keys.  But I haven't dug too deep
> into the context.  Plus the pgp.mit.edu site might have done some
> non-critical, minor changes in how the key looks like - compared to
> Samuli's version.

Yes, that's apparently what happened.


> That said, this security key is based upon the recommended sub-key
> approach [0].  That means that those of us among the developers can only
> use that key for signing and decryption data and with a fairly short
> lifetime (1 year).  They are not capable to sign other keys, updating
> the lifetime of the keys or any operation requiring the master key.  So
> I highly doubt Samuli have done anything special with that key.  Only I
> have the master key, which is well stored on a protected medium which is
> offline the very most of the time.
>
>
> [0] <https://alexcabal.com/creating-the-perfect-gpg-keypair/>

Thank you for your clear explanations, David -- and your patience!

Best regards,

Jon

