Message-ID: <4FE4501C.1020206@...1114...>
Date: Fri, 22 Jun 2012 12:59:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-5-git-send-email-arne@...1227...>
	<4FE445E2.4070509@...1114...>
In-Reply-To: <4FE445E2.4070509@...1114...>
Subject: Re: [Openvpn-devel] [PATCH 4/6] Remove ENABLE_CONNECTIONS ifdefs,
 connections were always on for a long time. Not that
 ENABLE_MAMAGEMENT_REMOTE was only depending on ENABLE_CONNECTIONS and is
 removed as well
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/06/12 12:16, David Sommerseth wrote:
> On 18/06/12 20:39, Arne Schwabe wrote:
>> 
>> Signed-off-by: Arne Schwabe <arne@...1227...> --- 
>> src/openvpn/init.c    |   12 ------------ src/openvpn/manage.c  |
>> 8 -------- src/openvpn/manage.h  |    6 ------ 
>> src/openvpn/options.c |   24 ------------------------ 
>> src/openvpn/options.h |   19 ------------------- 
>> src/openvpn/syshead.h |   16 +--------------- 6 files changed, 1
>> insertions(+), 84 deletions(-)
>> 
> 
> Applied to master.

The ACK for this patch can be found here:
<http://mid.gmane.org/4FE44882.3090706@...515...>


kind regards,

David Sommerseth


> commit f8488d16400888b5c5f599cc2eb6e383bf9dd589 Author: Arne
> Schwabe <arne@...1227...> Date:   Mon Jun 18 20:39:07 2012 +0200
> 
> Remove ENABLE_CONNECTIONS ifdefs
> 
> Connections were always on for a long time. Note that
> ENABLE_MAMAGEMENT_REMOTE was only depending on ENABLE_CONNECTIONS
> and is removed as well
> 
> Signed-off-by: Arne Schwabe <arne@...1227...> Acked-by: James
> Yonan <james@...515...> Message-Id:
> 1340044749-10694-5-git-send-email-arne@...1227... URL:
> http://article.gmane.org/gmane.network.openvpn.devel/6744 
> Signed-off-by: David Sommerseth <davids@...1347...>
> 
> 
> kind regards,
> 
> David Sommerseth
> 
> 
> 
> 
> ------------------------------------------------------------------------------
>
> 
Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond.
> Discussions will include endpoint security, mobile security and the
> latest in malware threats.
> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________ Openvpn-devel
> mailing list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kUBwACgkQDC186MBRfrrjUACfeAtQVy83K07YdOPrfDVLdJMi
9A0AoJMSQcQ4Q4/VdQZcr9KsLOFltpFs
=GrWY
-----END PGP SIGNATURE-----

