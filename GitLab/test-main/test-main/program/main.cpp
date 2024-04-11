#include <iostream>
#include <QApplication>
#include <QPushButton>
#include <QString>
#include <boost/shared_ptr.hpp>
#include <QTextStream>

using namespace std;

int main(int argc, char *argv[])
{
    //QApplication app(argc, argv);
    QString hi = "hello world!";
    QTextStream out(stdout);
    out << hi << endl;
    //QPushButton pb(hi);
    //pb.show();
    boost::shared_ptr<double[1024]> p1( new double[1024] );
    //return app.exec();
}
