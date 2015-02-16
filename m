Message-ID: <54E1F380.5070304@...1114...>
Date: Mon, 16 Feb 2015 14:41:20 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1424010266-5910-1-git-send-email-steffan@...1856...>
	<54E0B4A2.5090006@...1227...>
In-Reply-To: <54E0B4A2.5090006@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Disable SSL compression
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 15/02/15 16:00, Arne Schwabe wrote:
> On 15.02.2015 15:24, Steffan Karger wrote:
>> As reported in trac #502, SSL compression can cause problems in some corner
>> cases.  OpenVPN does not need SSL compression, since the control channel is
>> low bandwidth.  This does not influence the data channel compressen (i.e.
>> --comp or --comp-lzo).
>>
>> Even though this has not yet been relevant for OpenVPN (since an attacker
>> can not easily control contents of control channel messages), SSL
>> compression has been used in the CRIME and BREACH attacks on TLS.  TLS 1.3
>> will probably even remove support for compression all together, for
>> exactly this reason.
>>
>> Since we don't need it, and SSL compression causes issues, let's just
>> disable it in OpenSSL builds.  PolarSSL has no run-time flag to disable
>> compression, but is by default compiled without compression.
>>
> ACK from me. Sounds sensible to me. If do not support 0.9.8 anymore (in
> -master perhaps?) I would like this to be commited without ifdef.

We've agreed to support RHEL5 until it goes EOL, which is March 31,
2017. [1]  As RHEL5 is on 0.9.8 we need to support it.  RHEL6 is on
1.0.1, so we'll have something to look forward too ;-)


[1] There is also an additional "extended life cycle" which RHEL
    customers may opt-in for (for an additional fee), which I don't
    think we should relate too.
    <https://access.redhat.com/support/policy/updates/errata>


-- 
kind regards,

David Sommerseth

