Message-ID: <4C9C59A9.5090804@...1114...>
Date: Fri, 24 Sep 2010 09:56:25 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>	<4C8E9E7B.9020308@...1299...>	<20100914074032.GA10703@...1296...>	<4C8F3C04.8020904@...1147...>
	<20100914113722.GB10703@...1296...>
	<4C8F79BC.7090602@...1114...> <4C9C5002.4070806@...1147...>
In-Reply-To: <4C9C5002.4070806@...1147...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/09/10 09:15, Jan Just Keijser wrote:
> Yo all,
[...snip...]
> I was just browsing through the 2.1.3 source tree and found this in ssl.c:
> 
> 3379 static bool
> 3380 push_peer_info(struct buffer *buf, struct tls_session *session)
> 3381 {
> 3382   struct gc_arena gc = gc_new ();
> 3383   bool ret = false;
> 3384
> 3385 #ifdef ENABLE_PUSH_PEER_INFO
> 3386   if (session->opt->push_peer_info) /* write peer info */
> 3387     {
> 3388       struct env_set *es = session->opt->es;
> 3389       struct env_item *e;
> 3390       struct buffer out = alloc_buf_gc (512*3, &gc);
> 3391
> 3392       /* push version */
> 3393       buf_printf (&out, "IV_VER=%s\n", PACKAGE_VERSION);
> 3394
> 3395       /* push platform */
> 3396 #if defined(TARGET_LINUX)
> 3397       buf_printf (&out, "IV_PLAT=linux\n");
> 3398 #elif defined(TARGET_SOLARIS)
> 
> 
> this gets called if --push-peer-info is specified . This seems to be new
> for 2.1.3 - has anyone tested it?

Good catch ... this is the commit which introduces it.  (SVN r5668)
You're right, this is in 2.1.2/2.1.3

commit aaf72974672e4f2af2053247b63ef6f06bdc80c0
Author: James Yonan <james@...515...>
Date:   Tue Jun 1 07:12:27 2010 +0000

    Implemented a key/value auth channel from client to server.

    Version 2.1.1i


    git-svn-id:
http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn@...1409...
e7ae566f-a301-0410-adde-c780ea21d3b5


<sarcastic>
  And according to our normal procedure, this is of course not
  documented in the man page.
</sarcastic>

Thanks, JJK for catching this!  I don't think many have tested it -
except James.  So if you wouldn't mind testing it out and maybe shed
some knowledge about it, that would be great!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkycWacACgkQDC186MBRfrrFyACfcv0yz0Y+PuiuN5yKtU7rFIOy
xcoAni3AdaQuYG2S7aWK1yni1JwKMahA
=tr7E
-----END PGP SIGNATURE-----

