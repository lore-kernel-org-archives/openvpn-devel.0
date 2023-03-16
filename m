Date: Thu, 16 Mar 2023 10:27:18 +0100 (CET)
Message-Id: <202303160927.32G9RIoZ066276@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315013516.1256700-2-selva.nair@...277...>
References: <20230315013516.1256700-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Import some sample certificates
 into Windows store for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is a welcome addition so we can have actual cryptoapi unit 
tests.  The code looks reasonable, and GHA says "it passes"...

	Run ./unittests/cryptoapi_testdriver.exe
	[==========] Running 2 test(s).
	[ RUN      ] test_parse_hexstring
	[       OK ] test_parse_hexstring
	[ RUN      ] import_certs
	[  PASSED  ] 2 test(s).
	[       OK ] import_certs
	[==========] 2 test(s) run.


I have tried testing this on a "real" Win10 VM, but I am missing some
intricacies with the cert store - I wanted to see if certs are properly
cleaned up, but I can't even see my own .p12 I have imported, so I am
doing something wrong... 

Your patch has been applied to the master and release/2.6 branch.

commit d6cf0239e835d98b66c71d701e70128db9ca7e9a (master)
commit e6011868c40aaf91d30d084b1b454f7709c855fd (release/2.6)
Author: Selva Nair
Date:   Tue Mar 14 21:35:13 2023 -0400

     Import some sample certificates into Windows store for testing

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230315013516.1256700-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26417.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


