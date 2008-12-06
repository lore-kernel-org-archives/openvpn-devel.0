Message-ID: <493A3890.3020304@...1114...>
Date: Sat, 06 Dec 2008 09:32:16 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <722622.75064.qm@...1154...>
In-Reply-To: <722622.75064.qm@...1154...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Availability of GA Load for 2.1
 series
Reply-To: openvpn-users@lists.sourceforge.net
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
To: keyurpujara@...293...
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net



Keyur Pujara wrote:
>> Which release candidate of 2.1 series is recommended for
>> "Production Use"?
>>
>> Cross-Posting on Development mailing-list: Requesting
>> comment on this aspect and a visibility on planned GA date
>> for 2.1 series if any. 
> 
> 
> Would help if someone could reply/share their experience with 2.1 series on above perspective. Also - any comment on planned GA date for 2.1 series.

I've been running OpenVPN 2.1 RC 11, 13 and 15 stable in production environment since June.  I have
not had any particular issues.  The site is not extremely hard tested, but stability is present.  I
did some long-term testing on RC 11, with TLS keys being renewed every 10 minutes and had the
session open for about 50 hours.  The connections was rock solid, even though a little bit slower
due to the very frequent key renewal.

In this setup, I'm using dev-type tap, UDP, LZO, TLS (server/client), ifconfig-pool,
client-config-dir, client-to-client, persist-{key,tun}, AES-CBC cipher, chroot, management, running
as non-root user and the plugin option.  The plugin being used is my own authentication plugin
(http://www.eurephia.net)

During this long run, I also did not notice any obvious memory leaks.  It simply felt rock solid.

I hope this was helpful for you (or others).  Regarding GA date, I'm also waiting for this date.


kind regards,

David Sommerseth

