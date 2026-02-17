Message-ID: <230719e9-bfd7-479e-9bb2-4ef8bc59413b@...2181...>
Date: Tue, 17 Feb 2026 01:45:33 +0100
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
Content-Language: en-US
Subject: [Openvpn-devel] coming up with default values for --keepalive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Dear all,

I would like to propose a patch that sets some reasonable default values 
for the --keepalive option on the server.

This way, when starting OpenVPN, a user does not need to care about this 
param, until they feel it's time to customize the behaviour.

However, there is no golden value (as usual) which will make everybody 
super happy.

For this reason I am here asking you all what are the common values you 
pass to --keepalive.

The manpage has an example in it with "10 60", but some people may feel 
10s ping interval is too frequent.

I believe it is a reasonable common value (and people with specific 
constraints will still be able to customize it!), but I want to hear 
your opinion.


Please let me know by replying to this thread!


Thanks a lot!
Best Regards,

-- 
Antonio Quartulli


-- 
Antonio Quartulli

