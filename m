Message-ID: <4F307A83.8020606@...1388...>
Date: Tue, 07 Feb 2012 14:12:35 +1300
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Assertion failed at buffer.c:313
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi guys

I experience "Assertion failed at buffer.c:313" on my RHEL5/x64 caused by:

commit bee92b479414d12035b0422f81ac5fcfe14fa645
Author: Adriaan de Jong <dejong@...1435...>
Date:   Sun Feb 5 12:51:25 2012 +0100

     Removed support for calling gc_malloc with a NULL gc_arena struct

Once this patch is reverted OpenVPN compiles and runs smoothly.

Michal

