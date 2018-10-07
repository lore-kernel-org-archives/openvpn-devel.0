Date: Sun, 7 Oct 2018 10:50:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007085046.GS11393@...2460...>
MIME-Version: 1.0
Subject: [Openvpn-devel] windows build warnings
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
To: openvpn-devel@lists.sourceforge.net

Hi,

our windows build seems to have grown a few new warnings with some
of the recent refactoring...?

tun.c: In function 'ipconfig_register_dns':
tun.c:4870:10: warning: variable 'status' set but not used [-Wunused-but-set-variable]
     bool status;
          ^
tun.c: In function 'service_enable_dhcp':
tun.c:5202:11: warning: unused variable 'len' [-Wunused-variable]
     DWORD len;
           ^

win32.c: In function 'win32_pause':
win32.c:688:13: warning: variable 'status' set but not used [-Wunused-but-set-va
riable]
         int status;
             ^

can I interest someone to run a windows build, and go for the low-hanging
fruit?

("unused variable" in #ifdef _WIN32 code is likely fairly straightforward,
signed/unsigned pointer stuff might not be worth jumping through hoops
because fixing MinGW might make the warning reoccur on the MSVC side...)

Gert Doering
-- 
have you enabled IPv6 on something today...?

SpaceNet AG                      Vorstand: Sebastian v. Bomhard, Michael Emmer
Joseph-Dollinger-Bogen 14        Aufsichtsratsvors.: A. Grundner-Culemann
D-80807 Muenchen                 HRB: 136055 (AG Muenchen)
Tel: +49 (0)89/32356-444         USt-IdNr.: DE813185279

