From: Charles Duffy <cduffy@...294...>
Message-ID: <pan.2004.12.22.10.21.55.867168@...294...>
References: <20041222100009.GE1926@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Fwd: openvpn config parsing
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Dec 22 02:24:03 2004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Wed, 22 Dec 2004 11:00:09 +0100, Alberto Gonzalez Iniesta wrote:
> Recent updates of openvpn appear to have changed the handling of
> whitespace in tls certificate names.
  ...
> Now it needs '_' not '.' for spaces:

My guess is that this is a consequence of some string-handling changes
that were going on around 2.0-beta12 to 2.0-beta15.


