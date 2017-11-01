From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Nov 2017 23:03:38 +0100
Message-Id: <20171101220342.14648-1-steffan@...1856...>
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH v2] Don't throw fatal errors from
 create_temp_file()
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
To: openvpn-devel@lists.sourceforge.net

Hi,

The following four patches are a rebased and reordered set of patched that
replace the original 2 patches I send in September.  These should include
fixes for all Antonio's and David's comments (where needed).

-Steffan


