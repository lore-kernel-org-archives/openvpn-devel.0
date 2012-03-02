MIME-Version: 1.0
Date: Fri, 02 Mar 2012 15:32:13 +0100
From: michael-dev <michael-dev@...1528...>
Message-ID: <97ea10c3e48081835960380fd7ba76e0@...1528...>
Subject: [Openvpn-devel] setting common-name from plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

I've got a openvpn radius authentication plugin (username/password) 
here [1,2]. Though my radius server is really friendly to users (e.g. 
you might add or strip the domain as you like, upper/lower-case does not 
matter, users might have multiple usernames for different reasons), I 
still want each user to connect only ones to openvpn in order to 
mitigate sharing credentials.
Radius has the chargeable-user-identity reply attribute that could be 
used to set the common-name, but I did not find any way in openvpn to do 
this from plugin.
Could a patch adding a way to set the common name from radius plugin 
similar to return_list in OPENVPN_PLUGIN_CLIENT_CONNECT_V2 be accepted?

Regards,
  M. Braun
--
[1] 
http://subversion.fem.tu-ilmenau.de/websvn/wsvn/openvpn-radius-auth/trunk/
[2] 
http://subversion.fem.tu-ilmenau.de/repository/openvpn-radius-auth/trunk/


