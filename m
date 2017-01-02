From: Gisle Vanem <gvanem@...2101...>
Message-ID: <f49ae3c3-70c8-3169-4776-a7b89b7e8799@...2101...>
Date: Mon, 2 Jan 2017 15:28:58 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Crash in options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

Just as an experiment, I compiled openvpn.exe using MinGW w/o
'ENABLE_CRYPTO' defined. Duh, you think. What would be the benefit of
that? I ask myself the same. This code (at line 4079):

#else  /* ifdef ENABLE_CRYPTO */
    fprintf(fp, usage_message,
            title_string,
            o.ce.connect_retry_seconds,
            o.ce.local_port, o.ce.remote_port,
            TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
            o.verbosity);
#endif

uses a 'title_string[]' as format with no parameters specified and
thus crashes as expected. So is all code outside '!defined(ENABLE_CRYPTO)'
really dead code or what?

-- 
--gv

