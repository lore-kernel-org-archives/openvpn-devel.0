From: Davide Brini <dave_br@...1278...>
Date: Mon, 26 Apr 2010 16:08:52 +0100
References: <1272210565-9312-1-git-send-email-dave_br@...1278...>
	<201004261148.38378.dave_br@...1278...> <1272293456.28330.3@...1207...>
In-Reply-To: <1272293456.28330.3@...1207...>
MIME-Version: 1.0
Message-Id: <201004261608.52121.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH] Serial number export, fixed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On Monday 26 Apr 2010 15:50:56 Karl O. Pinc wrote:

> > > itself.  So if the script could fail gracefully giving a hint like
> > > "you've not done as I told you to", some support issues will be
> > > avoided.
> >
> > Ok, that makes sense. I didn't look at it this way, but then I
> > perfectly know what you mean, so I'll change it to exit if it detects that
> > something is not set properly.
> 
> FWIW, and I don't know what the code does so I can't say
> whether this would be useful, but if you go to http://example.com
> or http://www.example.com (but not http://foo.example.com) you
> get a bare-bones web page explaining that you're using a
> reserved domain.

Right, I'll do something like this then:

# Edit the following values to suit your needs

# OCSP responder URL (mandatory)
# YOU MUST UNCOMMENT ONE OF THESE AND SET IT TO A VALID SERVER
#ocsp_url="http://ocsp.example.com/"
#ocsp_url="https://ocsp.secure.example.com/"

So the user will need to actively uncomment one of those, /and/ also set it to 
a valid URL. Leaving them commented makes the script fail because of sanity 
checks I added later. Uncommenting but leaving it set to those values will 
make the subsequent OCSP validation fail (obviously).

In both cases, OpenVPN's --tls-check (which is where the script is supposed to 
be called) will fail in turn, aborting the client connection. That should be 
enough of a heads-up for the lazy or distracted user.

(I still think it would be nice to have some sort of channel to send errors to 
OpenVPN's main log from the children scripts or programs, so users could 
inspect it.)

Thanks!

-- 
D.

