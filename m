Date: Thu, 12 Nov 2009 18:37:34 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091112153734.GA7157@...1066...>
References: <20091110161632.GA31301@...1276...>
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>
	<4AFAA745.4030806@...1114...>
	<20091111125443.GA29471@...1066...>
	<4AFAD26C.7010900@...1114...>
MIME-Version: 1.0
In-Reply-To: <4AFAD26C.7010900@...1114...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending	on
	the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.11.11 at 16:04:12 +0100, David Sommerseth wrote:
> I completely agree, that under normal circumstances, it should be enough
> by letting OpenSSL take care of the certificate chain.  But as OpenVPN
> now do list more certificates already, I was just trying to keep that
> possibility still open.
> 
> In the OpenVPN plug-in I've written which does username, password and
> certificate authentication, I've been playing with an idea of using the
> certificate chain to apply different "rules" (network, login hours, etc)
> based on the certificate chain as well.

I think it is what certificate policies are for (see RFC 5280).

Unfortinately  policy support is very poorly documented in the OpenSSL
(although some documentation for certificate chain verification was added 
in 1.0.0 beta 4 and it is applicable to early versions as well)

So my patch for policy checking allows only to specify
several policies to accept. It doesn't pass that policy which was found
in the certificate after all policy mappings found in CA certificates
were applied to scripts/plugins. 

There are also attribute certificates which can be used for such
autorization purposes as well.

