From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Feb 2016 01:51:02 -0500
Message-Id: <1455864663-19751-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Restrict options/configs for startup
	through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

The pacth is in the next email.

This is not yet tested extensively, but has passed some quick tests.
A simple approach of parsing the options string is used instead of passing structs:
the latter will break the GUI everytime a new option is added to the white-list.

Current white-list is just what the GUI needs, but its easy to extend.

- Only limited tests could be done with the stock GUI:

- Because of GUI limitations, check the event viewer for startup errors
  (the GUI will just hang for 15 seconds and say connection failed)

Thanks,

Selva

