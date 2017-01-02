References: <f49ae3c3-70c8-3169-4776-a7b89b7e8799@...2101...>
	<20170102145543.GM78624@...1296...>
From: Gisle Vanem <gvanem@...2101...>
Message-ID: <9d41f9dd-a587-5c1e-2e0d-ebb6c921f4ae@...2101...>
Date: Mon, 2 Jan 2017 17:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170102145543.GM78624@...1296...>
Subject: Re: [Openvpn-devel] Crash in options.c
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
To: openvpn-devel@lists.sourceforge.net

Gert Doering wrote:

>> uses a 'title_string[]' as format with no parameters specified and
>> thus crashes as expected. So is all code outside '!defined(ENABLE_CRYPTO)'
>> really dead code or what?
> 
> Actually, "usage_message" is the format string here...  

Ah, my bad. Then it's a simple fix:

--- a/options.c 2017-01-02 09:58:38
+++ b/options.c 2017-01-02 17:15:10
@@ -4080,6 +4080,7 @@
     fprintf(fp, usage_message,
             title_string,
             o.ce.connect_retry_seconds,
+            o.ce.connect_retry_seconds_max,
             o.ce.local_port, o.ce.remote_port,
             TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
             o.verbosity);

> There might still be bugs here, though - as in: someone adapted the 
> "#ifdef ENABLE_CRYPTO" part of the usage_message and forgot to change
> arguments in the the #else case.   While we do test builds with
> --disable-crypto, I'm not sure anyone has run "openvpn --help" with
> such a build in the last 5 years...

-- 
--gv

