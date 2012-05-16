MIME-Version: 1.0
Date: Wed, 16 May 2012 10:17:11 +0300
Message-ID: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] eurephia plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello David,

I guess this is yours:
---
 *  Additions for eurephia plugin done by:
 *         David Sommerseth <dazo@...384...> Copyright (C) 2009
---

Looking at the code the eurephia plugin only do the following:
---
#ifdef ENABLE_PLUGIN_EUREPHIA
  /* export X509 cert SHA1 fingerprint */
  {
    unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert, &gc);

    openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d", cert_depth);
    setenv_str (es, envname, format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1,
                                          ":", &gc));
  }
#endif
---

Can you please explain what this plugin is and why just remove the conditional?

Thanks,
Alon.

