MIME-Version: 1.0
In-Reply-To: <20170222154759.46402df4@...1799...>
References: <cover.1487368114.git.logout@...260...>
	<11477a0a3cf636572c84e0110a6f1b726bc60c2c.1487368114.git.logout@...260...>
	<1b42bd0d-ffbf-8c09-e313-13474b723a16@...1856...>
	<20170222154759.46402df4@...1799...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 22 Feb 2017 16:34:21 +0100
Message-ID: <CAA1AbxLtDgsrw7pje-c_Qu4j2XbGZod6zjbPfQSTieL+RWiqSw@...278...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 09/15] OpenSSL: don't use direct
 access to the internal of X509_STORE_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 22 February 2017 at 15:47, Christian Hesse <list@...1798...> wrote:
> Steffan Karger <steffan@...1856...> on Tue, 2017/02/21 22:30:
>> ACK.  Changes look good and tested against OpenSSL 0.9.8, 1.0.0, 1.0.1
>> and 1.0.2.
>
> You answered to a patch in the middle of a series. Does this ACK apply to the
> complete series or just this patch?

Just this one.  Not much brains left last night, so I only reviewed
this rather simple and independent patch out of the series :)

-Steffan

