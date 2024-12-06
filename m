MIME-Version: 1.0
From: Marc Leeman <marc.leeman@...277...>
Date: Fri, 6 Dec 2024 10:35:26 +0100
Message-ID: <CAH+fs=-Ng0RGzX3E5d9Q9HUEci8DYDEDVSK3V15tjXbWCepdfA@...278...>
Subject: [Openvpn-devel] spelling errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

FYI

While preparing a package for debian, lintian complained about some
spelling errors. I had a quick look, but since some are signals (e.g.
succeded), I didn't want to meddle with them atm.

I: openvpn3-client: spelling-error-in-binary Configration
Configuration [usr/libexec/openvpn3-linux/openvpn3-service-configmgr]
I: openvpn3-client: spelling-error-in-binary nam name
[usr/libexec/openvpn3-linux/openvpn3-service-backendstart]
I: openvpn3-client: spelling-error-in-binary occured occurred
[usr/libexec/openvpn3-linux/openvpn3-service-client]
I: openvpn3-client: spelling-error-in-binary recieved received
[usr/libexec/openvpn3-linux/openvpn3-service-sessionmgr]
I: openvpn3-client: spelling-error-in-binary succeded succeeded
[usr/libexec/openvpn3-linux/openvpn3-service-netcfg]
I: openvpn3-client: spelling-error-in-binary unkown unknown
[usr/sbin/openvpn3-admin]
I: openvpn3-client: typo-in-manual-page "allows to" "allows one to"
[usr/share/man/man1/openvpn3-config-manage.1.gz:41]
I: openvpn3-client: typo-in-manual-page reponsible responsible
[usr/share/man/man8/openvpn3-service-devposture.8.gz:42]

-- 
g. Marc

GPG: 827C FD74 BA46 8152 A041 F3A0 7A6A 4F17 5995 A65B

