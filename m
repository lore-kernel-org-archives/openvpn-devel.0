References: <20210318181258.89704-1-juliusz@...2525...>
 <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <040710dc-4c40-be88-6f82-6c6cbc2869ed@...1227...>
Date: Fri, 19 Mar 2021 00:18:09 +0100
MIME-Version: 1.0
In-Reply-To: <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 18.03.2021 um 21:52 schrieb David Sommerseth:
> If this is due to an outdated pkg-config, I'm reluctant to give this 
> patch an ACK.  Using properly up-to-date dependency stack should be a 
> reasonable precondition to build OpenVPN.  If it is due to unavailable 
> pkg-config, it's a different story. 

We support RHEL7, which also has pkgconfig 0.27. So that is also a 
problem. And even if RHEL7 shipped a version that was recent enough, 
denying Ubuntu 16 support because an old dependency that can be fixed 
with this small change like would be quite a hyprocrasy as we supported 
old RHEL versions for a long time in OpenVPN often needing a lot larger 
compromises. In fact RHEL7/CentOS 7 is currently in my opinion only 
reason to still support OpenSSL 1.0.2, which has has reached end of life 
on 2019-12-31.


Arne



