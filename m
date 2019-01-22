Date: Tue, 22 Jan 2019 20:05:52 +0100 (CET)
Message-Id: <201901221905.x0MJ5qZ9046686@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190122150333.1061-1-arne@...1227...>
References: <20190122150333.1061-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Rename
 tls_crypt_v2_read_keyfile into generic pem_read_key_file
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
To: Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Explanation makes sense, code looks good (just moving, except for the
error messages which change to print "*pem_name" instead of static
"tls-crypt-v2" always).

Your patch has been applied to the master branch.

commit 784ad902438a6c70f1b9e4f545ac2bbb4230a048
Author: Arne Schwabe
Date:   Tue Jan 22 16:03:28 2019 +0100

     Rename tls_crypt_v2_read_keyfile into generic pem_read_key_file

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190122150333.1061-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20190122150333.1061-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


