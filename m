Date: Tue, 10 Jan 2023 13:24:06 +0100 (CET)
Message-Id: <202301101224.30ACO6oj041967@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230105022718.1641751-3-selva.nair@...277...>
References: <20230105022718.1641751-3-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Propagate route error to
 initialization_completed()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

We discussed this previously, and it makes sense to take "route addition
errors" into account, even if we consciously decided (long before I got
involved...) that we consider these non-fatal, unlike ifconfig errors.

I have stared at the code, and it looks reasonable (we discussed the
approach before).

Some of the lines are now longer than 80 characters, with "short 
continuation lines", like this

+            ret = add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr, tt, flags,
+                                    &rl->rgi, es, ctx);

.. while our style guide permits "longer lines if the alternativ is
more ugly", in this case actually rewrapping would be nicer (not a 
showstopper), like this:

+            ret = add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.addr,
+                                    tt, flags &rl->rgi, es, ctx);

.. so two similarily-long lines, not one very long and one quite short.

The rewrappings of the add_route3() calls are welcome :-)


That it's only available for Windows and Linux/SITNL today is non-ideal, 
but I can see the motivation - for platforms where we can't distinguish
"genuine errors" and "EEXIST errors", err on the side of "keep old
behaviour, no new warnings".  We did want a major "routing glue rewrite"
for 2.6, which did not happen, so let's try again for 2.7...


I have tested "things still work" by subjecting this to the full 
client/server test on Linux (with SITNL, with and without DCO), and
run manual tests, as suggested

  openvpn --config base.ovpn --route 192.168.122.0 255.255.255.0 1.1.1.1

.. which ended unexpected...

    2023-01-10 13:05:15 sitnl_send: rtnl: generic error (-101): Network is unreachable
    2023-01-10 13:05:15 ERROR: Linux route add command failed
    2023-01-10 13:05:15 Initialization Sequence Completed

.. I did expect something about "with errors" here - and I think we
*should* print something, given that many (most?) *Linux* users will not
have a management-client-GUI running.

On the management interface, it does work fine:

    state
    1673352459,CONNECTED,ROUTE_ERROR,10.194.2.170,199.102.77.82,51194,,,fd00:abcd:194:2::1029

(and if there are no errors, it will display "CONNECTED,SUCCESS,")

I have not tested what the Windows GUI will do or display in this case.


Also, the EEXIST suppression of SITNL is really a bug that needs to be
fixed.  If I have duplicate routes...

    2023-01-10 13:11:40 net_route_v4_add: 10.194.0.0/16 via 10.194.2.169 dev [NULL] table 0 metric -1
    2023-01-10 13:11:40 net_route_v4_add: 10.194.0.0/16 via 10.194.2.169 dev [NULL] table 0 metric -1

.. installation just works fine, but...

    2023-01-10 13:12:00 net_route_v4_del: 10.194.0.0/16 via 10.194.2.169 dev [NULL] table 0 metric -1
    2023-01-10 13:12:00 net_route_v4_del: 10.194.0.0/16 via 10.194.2.169 dev [NULL] table 0 metric -1
    2023-01-10 13:12:00 sitnl_send: rtnl: generic error (-3): No such process
    2023-01-10 13:12:00 ERROR: Linux route delete command failed

.. it does not understand that the 2nd addition actually *failed*, so
tries to remove it, which creates an error that is in the wrong place,
and fully avoidable.  Antonio, you listening?


Your patch has been applied to the master and release/2.6 branch.

commit e04c253618ce2a1bb0996a67b81af891e8607fa9 (master)
commit 705a08ee5adcc74d51bc096592d561f35dc8661a (release/2.6)
Author: Selva Nair
Date:   Wed Jan 4 21:27:18 2023 -0500

     Propagate route error to initialization_completed()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230105022718.1641751-3-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25884.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


