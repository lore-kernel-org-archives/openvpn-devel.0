MIME-Version: 1.0
Date: Mon, 05 Mar 2012 17:44:10 +0100
From: michael-dev <michael-dev@...1528...>
Message-ID: <df756c8eb7a5fe440f97d573841a40cb@...1528...>
Subject: Re: [Openvpn-devel] setting common-name from plugin
Reply-To: openvpn-devel@lists.sourceforge.net
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

thanks for you reply.

I use OpenVPN in username/password mode with client-cert-not-required 
and username-as-common-name.
So by using the duplicate-cn=unset feature, multi_delete_dup already 
implements the lookup+drop functionality using the common-name, which is 
set to username in ssl.c:key_method_2_read after the authentication 
plugin is run.
I basically would want the plugin to be able to override to what 
set_common_name gets set in ssl.c, so multi_delete_dup could use the 
plugin generated value. The challenge is to combine this with the 
deferred authentication stuff, though timing already is fine.

Reimplementing using the plugin owns lookup table would do it, but 
would also be extra work that could be avoided.

Regards,
  M. Braun


