Date: Thu, 16 Mar 2023 10:39:49 +0100 (CET)
Message-Id: <202303160939.32G9dnGX066695@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230315013516.1256700-3-selva.nair@...277...>
References: <20230315013516.1256700-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add tests for finding
 certificates in Windows cert store
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

Code looks reasonable and tests what we want tested.  Tested with
a local MinGW build -> copied to windows10, and with GHA.

    [==========] Running 5 test(s).
    [ RUN      ] test_parse_hexstring
    [       OK ] test_parse_hexstring
    [ RUN      ] import_certs
    [       OK ] import_certs
    [ RUN      ] test_find_cert_bythumb
    [       OK ] test_find_cert_bythumb
    [ RUN      ] test_find_cert_byname
    [       OK ] test_find_cert_byname
    [ RUN      ] test_find_cert_byissuer
    [       OK ] test_find_cert_byissuer
    [==========] 5 test(s) run.
    [  PASSED  ] 5 test(s).

Your patch has been applied to the master and release/2.6 branch.

commit b538a334284716757c48026bf6ace95e33258943 (master)
commit a08d0c770d0c0cd2534a0a900bba358b1c44056f (release/2.6)
Author: Selva Nair
Date:   Tue Mar 14 21:35:14 2023 -0400

     Add tests for finding certificates in Windows cert store

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230315013516.1256700-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26415.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


